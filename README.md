# Zopfli Recompressor

## About

A simple shell script to recompress zip files in a given folder structure recursively using the [zopfli](https://github.com/google/zopfli) algorithm.
The script is capable of being interrupted at any point, resuming work at the current working position at a later time.

## Requirements

In order to work the script needs the following dependencies installed on your system:

* [advzip](http://www.advancemame.it/comp-readme), which is part of the [AdvanceCOMP](http://www.advancemame.it/comp-readme) collection of tools
* [GNU Parallel](https://www.gnu.org/software/parallel/)

## Usage

```text
Zopfli Recompressor

Usage:
    zopfli-recompress.sh <input-directory> <file-extension> <number-of-threads> <progress-file>

Example:
    zopfli-recompress.sh /my/directory/with/files zip 8 ./progress.log

    This command will recompress all files within '/my/directory/with/files',
    which have the file ending of .zip. Eight files will be processed in parallel.
    The progress will be logged to a file named 'progress.log' in the current directory.
    If the process is started again the last progress will be loaded from the log in order
    to resume operation.

```

## Reasoning / Limitations

The script was thrown to together quickly, as I needed some recompression work done. Don't hold me or anybody responsible, if it eats your socks, or pets your cat ;).
