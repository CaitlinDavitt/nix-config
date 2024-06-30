{ pkgs-unstable, ... }: 
{
  environment.systemPackages = with pkgs-unstable; [
    scala
    sbt
    metals
    spark
    hadoop
  ];
}
