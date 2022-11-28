# Xcode Project Info
**[Bitrise](https://www.bitrise.io) step which extracts Xcode project information to environment variables**

## Description
This step will simply extract Xcode project information (Version and Build), and export them into environment variables prefixed with `XPI_`.

Afterwards, you can use these environment variables in other steps (ie. sending message on Slack).

**NOTE:** This version is intended for use on projects created with Xcode 11 and onwards.
If your project still uses an Info.plist to store the explicit version and build values then use **2.X.X** of this step.

## Outputs

| Env Var        | Description                                                 |
| -------------- | ----------------------------------------------------------- |
| `$XPI_VERSION` | Version ($CFBundleShortVersionString or $MARKETING_VERSION) |
| `$XPI_BUILD`   | Build ($CFBundleVersion or $CURRENT_PROJECT_VERSION)        |

## How to use this Step (3.X.X)

In version 3 of this step, the inputs are setup to function with xcode projects and workspaces.
Configuring the step involves pointing to an `.xcodeproj` file and a target name or pointing to an `.xcworkspace` file and a scheme name.
There is no longer a path to an `Info.plist` file as Xcode now manages version information in build settings.

### I use an `xcodeproj`
When using an xcode project then you only need to provide a path to the xcodeproj file and the particular target to read from.
Use the 'Project path' and 'Project target' inputs to the point to your `xcodeproj` file and to specify the target.

### I use an `xcworkspace`
If you are using Xcode workspaces then use the 'Workspace path' and 'Workspace scheme name' inputs to qualify the target to read from.
You must provide values for _**both**_ inputs, the workspace path alone is not enough to resolve the version and build values.

## How to use this Step (2.X.X)

You just need to set relative path from Source directory to `Info.plist` file.
Source directory is considered to be root directory created by the Git Clone step.
If your `Info.plist` file is in **RootDir/ProjectName** directory (for example), 
then you should set this input to `ProjectName/Info.plist`.

For Xcode 11 projects, you will need to set the relative path from source directory to the `.xcodeproj` directory.
Additionally, you can specify which target you want to get the version & build numbers for.
If actual values are set in Info.plist, they will be used instead of the values from the xcodeproj. This means it won't break if you set a build number within your workflow for instance.