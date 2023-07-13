# falcon-nix
Environment for running Falcon-40B on NixOS

## Instructions

1. Download TheBloke's experimental 3-bit AutoGPTQ
   https://huggingface.co/TheBloke/falcon-40b-instruct-3bit-GPTQ

2. Everything should be nixified so on NixOS just do: `nix run`

   By default, the `falcon` test app in this repo expects to find the dataset
   in `../falcon-40b-instruct-3bit-GPTQ`

Using Geforce RTX 4090, expect it to take few minutes to generate a lama story.
