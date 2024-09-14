{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    (python3.withPackages (ps:
      with ps;
      with python3Packages; [
        # flask
        # flask-cors
        # tensorflow
        # sklearn-deap
        # jupyter
        # ipython
        # github3_py

        # Uncomment the following lines to make them available in the shell.
        pandas
        polars
        numpy
        matplotlib
        # nbconvert
        # pyppeteer
        tomlkit
        toml
        virtualenv
        # gcc-unwrapped
        # typing-extensions
        # mrjob
      ]))
    # hadoop
    # spark
  ];
}
