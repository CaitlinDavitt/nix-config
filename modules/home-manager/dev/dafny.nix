{pkgs-unstable, ...}: {
  environment.systemPackages = with pkgs-unstable; [
    dafny
    vscode
    dotnet-sdk
    dotnet-runtime
    dotnet-aspnetcore
    icu.dev
    icu72.dev
  ];
}
