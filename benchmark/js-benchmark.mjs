import { readFile, writeFile } from "fs/promises"
import jsonMinify from "jsonminify"

const jsonFiles = ["./benchmark/fixture-warmup.json", "./benchmark/fixture2.json"]

await Promise.all(
  jsonFiles.map(async (jsonFile) => {
    const jsonString = await readFile(jsonFile, "utf8")
    const data = await jsonMinify(jsonString)
    return await writeFile(jsonFile, data)
  })
)
