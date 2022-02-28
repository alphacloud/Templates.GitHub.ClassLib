// DEFAULTS

#load "./.build/definitions.cake"


// ARGUMENTS

var target = Argument("target", "Default");

ProjectSettings settings = new ProjectSettings("alphacloud", "REPO_NAME", "ClassLib")
{
    CodeCoverage =
    {
        IncludeFilter = "+[NAMESPACE_PREFIX.ClassLib]*"
    }
};


// SETUP / TEARDOWN

Setup<BuildInfo>(context =>
{
    var buildInfo = BuildInfo.Get(context, settings); // settings must be declared in main file

    Information("Building version {0} (tagged: {1}, local: {2}, release branch: {3})...", buildInfo.Version.NuGet,
        buildInfo.Repository.IsTagged, buildInfo.IsLocal, buildInfo.Repository.IsReleaseBranch);
    CreateDirectory(buildInfo.Paths.ArtifactsDir);
    CleanDirectory(buildInfo.Paths.ArtifactsDir);

    return buildInfo;
});

Teardown(context =>
{
    // Executed AFTER the last task.
});


// TASKS

#load "./.build/tasks.cake"


// EXECUTION

RunTarget(target);
