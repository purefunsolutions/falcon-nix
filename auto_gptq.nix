{
  fetchPypi,
  pythonPackages,
  rouge,
}:
pythonPackages.buildPythonPackage rec {
  pname = "auto_gptq";
  version = "0.2.2";

  src = fetchPypi {
    inherit pname version;
    extension = "tar.gz";
    hash = "sha256-SIWvJRTCEkKufZAr+njjL6meVCeE3xAGK3aHgNoigiQ=";
  };
  propagatedBuildInputs = [
    pythonPackages.accelerate
    pythonPackages.datasets
    pythonPackages.numpy
    pythonPackages.safetensors
    pythonPackages.transformers
    rouge
  ];

  doCheck = false;
}
