
module.exports = {
  testEnvironment: 'node',
  moduleFileExtensions: ['js', 'ts'],
  transform: {
    '^.+\\.(t|j)s$': 'ts-jest',
  },
  testMatch: ['**/*.spec.ts'],
};
