@isTest
private class DeprecatedAPIVersionScanner_Tests {
    private static Integer apiFamilyColumnIndex;
    private static Integer apiVersionColumnIndex;

    private class ColumnNotFoundException extends Exception {
    }

    @IsTest
    static void logsContainDeprecatedAPIVersions() {
        Set<String> apiVersionsInUse = new Set<String>();
        List<EventLogFile> logFiles = [
            SELECT LogFile
            FROM EventLogFile
            WHERE EventType = 'ApiTotalUsage'
        ];
        if (logFiles.size() >= 1) {
            // Check the log files for deprecated API versions
            for (EventLogFile logFile : logFiles) {
                apiVersionsInUse.addAll(
                    buildSetOfReferencedAPIVersions(
                        parseLogFile(logFile.LogFile.toString())
                    )
                );
            }
            System.Assert.areEqual(
                0,
                apiVersionsInUse.size(),
                'The following API versions are deprecated but still in use: ' +
                String.join(new List<String>(apiVersionsInUse), ', ')
            );
        }
        // implicit else here is that we have no logFiles to check.
        System.Assert.areEqual(
            0,
            logFiles.size(),
            'This assertion must logically be true.'
        );
    }

    private static List<List<String>> parseLogFile(String logFile) {
        List<List<String>> returnData = new List<List<String>>();
        List<String> rows = logFile.split('\n');
        for (String row : rows) {
            returnData.add(sanitizeCSVRow(row));
        }
        return returnData;
    }

    private static List<String> sanitizeCSVRow(String row) {
        List<String> columns = row.split(',');
        for (
            Integer columnIndex = 0; columnIndex < columns.size(); columnIndex++
        ) {
            columns[columnIndex] = columns[columnIndex]
                .substring(1, columns[columnIndex].length() - 1);
        }
        return columns;
    }

    private static Integer getColumnIndexForLabel(
        List<List<String>> rows,
        String label
    ) {
        Integer index = rows[0].indexOf(label);
        if (index == -1) {
            throw new DeprecatedAPIVersionScanner_Tests.ColumnNotFoundException(
                'Could not find ' + label + ' column'
            );
        }
        return index;
    }

    private static Set<String> buildSetOfReferencedAPIVersions(
        List<List<String>> rows
    ) {
        if (apiFamilyColumnIndex == null) {
            apiFamilyColumnIndex = getColumnIndexForLabel(rows, 'API_FAMILY');
        }

        if (apiVersionColumnIndex == null) {
            apiVersionColumnIndex = getColumnIndexForLabel(rows, 'API_VERSION');
        }
        Set<String> foundAPIVersions = new Set<String>();
        // Note we start at 1 - ignoring row 0 which is headers.
        for (Integer rowIndex = 1; rowIndex < rows.size(); rowIndex++) {
            foundAPIVersions.add(generateAPIVersionFromLogRow(rows[rowIndex]));
        }
        return foundAPIVersions;
    }

    private static String generateAPIVersionFromLogRow(List<String> row) {
        return row[DeprecatedAPIVersionScanner_Tests.apiFamilyColumnIndex] +
            ' v' +
            row[DeprecatedAPIVersionScanner_Tests.apiVersionColumnIndex];
    }
}
