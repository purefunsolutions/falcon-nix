{
  auto_gptq,
  lib,
  pythonPackages,
}:
pythonPackages.buildPythonApplication {
  pname = "falcon";
  version = "0.1";
  src = ./.;
  propagatedBuildInputs = [
    pythonPackages.accelerate
    pythonPackages.einops
    pythonPackages.torch
    pythonPackages.transformers
    auto_gptq
  ];
}
