# csv-split

A C utility for splitting large CSV files into smaller chunks.

## Building

To build the utility, run:

```bash
make
```

This command will create the executable file `csv-split` in the project's root directory.

## Installation

To install the utility system-wide (defaults to `/usr/local/bin`), first make the script executable and then run it:

```bash
chmod +x install.sh
sudo ./install.sh
```

You might need superuser privileges (`sudo`) to copy the file to a system directory.

Alternatively, you can use the Makefile target:

```bash
make install
```
This also requires `sudo` if installing to a system directory.

## Usage

```bash
csv-split <input_csv> <output_pattern> <chunk_size>
```

*   `<input_csv>`: Path to the source CSV file.
*   `<output_pattern>`: Name pattern for the output files. For example, if you specify `part`, the output files will be named `part-1.csv`, `part-2.csv`, etc.
*   `<chunk_size>`: The number of data rows (excluding the header row) to include in each output file.

### Example

Split the file `large_data.csv` into chunks of 1000 data rows each, with output files named `data_chunk-1.csv`, `data_chunk-2.csv`, ...:

```bash
csv-split large_data.csv data_chunk 1000
```

## Cleaning

To remove the compiled executable from the project directory, run:

```bash
make clean
``` 