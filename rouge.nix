{
  fetchPypi,
  pythonPackages,
}:
pythonPackages.buildPythonPackage rec {
  pname = "rouge";
  version = "1.0.1";

  src = fetchPypi {
    inherit pname version;
    extension = "tar.gz";
    hash = "sha256-ErSDRspH1rzzxFBh8xVFK5zOwGIO6JXshbfvw9VKrjQ=";
  };
  propagatedBuildInputs = [
    pythonPackages.six
  ];

  doCheck = false;
}
