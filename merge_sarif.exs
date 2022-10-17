Mix.install([
  {:jason, "~> 1.4"}
])

merged_sarif =
  Path.wildcard("./*.sarif")
  |> Enum.reduce(%{}, fn path, acc ->
    json_map =
      path
      |> File.read!()
      |> Jason.decode!()

    Map.merge(acc, json_map, fn
      "runs", [val_acc], [val_json] ->
        Map.merge(val_acc, val_json, fn
          "results", val_before, val_after ->
            val_before ++ val_after

          _, _, val ->
            val
        end)

      _, _, val_json ->
        val_json
    end)
  end)
  |> Jason.encode!(pretty: true)

File.write!("results.sarif", merged_sarif)
