<h1 align="center">Multi-Coolty</h1>

<div align="center">

   <a href=""> ![CI](https://github.com/tkosman/multi-coolty/actions/workflows/ci.yml/badge.svg) </a>
   <a href=""> ![Language Count](https://img.shields.io/github/languages/count/tkosman/multi-coolty) </a>

</div>

Multi-Coolty is an ultimate hello-world project that demonstrates how multiple programming languages can be integrated into a single binary using shared libraries (`.so` files).
Less programming - more configuration!


## Supported Languages
The following programming languages are supported:
- Brainfuck
- C
- C++
- Go
- Rust

## Usage

To run the project, simply clone the repository and execute the build script. You need to have Docker installed on your machine.

```bash
git clone https://github.com/tkosman/multi-coolty.git
cd multi-coolty
./build.sh
docker run --rm hello_final
```
See how each language prints its hello-world message!

## How to Contribute

This project is about contributions! To add a new language plugin:

1. **Fork the repository** and create your feature branch (`git checkout -b hello-mylang`).
2. **Add your plugin:**
	- Place your hello-world source file in `hello_plugins/` (e.g., `hello_mylang.ext`).
	- Add a build script in `hello_build/` (e.g., `build_mylang.sh`).
	- Add a Dockerfile in `hello_docker/` (e.g., `Dockerfile.mylang`).
Please refer to existing plugins for guidance.
3. **Submit a pull request**, add which language you implemented.
4. **Monitor the CI checks** to ensure your plugin builds and runs correctly.
5. **Once merged**, see how GitHub Actions adds your language to the Supported Languages list!

## Project Structure

```
multi-coolty/
├── hello_plugins/      # Source files for each language
├── hello_build/        # Build scripts for each language
├── hello_docker/       # Dockerfiles for each language
├── build.sh            # Main build script
├── loader.c            # Loader source
├── README.md           # This file
```

## License

The code is licensed under the [MIT License](https://choosealicense.com/licenses/mit/). \
This license permits free use, modification, and distribution, with limitations on liability and warranty.
