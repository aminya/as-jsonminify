module jsonminify.cli;

import jsonminify.lib : minify;

import std.parallelism : parallel;
import std.getopt : getopt, defaultGetoptPrinter, GetoptResult;
import std.file : readText, write;

/** Print help */
void printHelp(GetoptResult optResult)
{
  return defaultGetoptPrinter("Usage: minify json files.\njsonminify -file file1.json -file file2.json",
      optResult.options);
}

void main(string[] args)
{
  string[] files;

  auto optResult = getopt(args, "file", "the json file to minify", &files);

  if (optResult.helpWanted || !files)
  {
    return printHelp(optResult);
  }

  foreach (ref file; files.parallel())
  {
    const string jsonString = readText(file);
    const minifiedJsonString = minify(jsonString);
    write(file, minifiedJsonString);
  }
}
