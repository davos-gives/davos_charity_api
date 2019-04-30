defmodule DavosCharityApi.Receipt do

  use Export.Python

  import IEx

  def call_python_method do
    {:ok, py} = Python.start(python_path: Path.expand("lib/python"))

    py |> Python.call(test(), from_file: "testing")
  end
end
