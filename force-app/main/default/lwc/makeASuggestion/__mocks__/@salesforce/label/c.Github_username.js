export const mockGitHubUsername = jest.fn();
const mock = jest.fn().mockImplementation(() => {
    return { default: mockGitHubUsername };
});

export default mock;
