type mtime = Mtime.t

let mtime_to_yojson mt =
  let ns = Mtime.to_uint64_ns mt in
  `Float (Int64.to_float (Int64.div ns 1000L))

type mtime_span = Mtime.span

let mtime_span_to_yojson span = `Float (Mtime.Span.to_us span)

type t =
  { name : string
  ; pid : int [@make.default 0]
  ; tid : int [@make.default 0]
  ; ph : char
  ; ts : mtime
  ; dur : mtime_span option [@yojson.default None]
  ; color : string option [@yojson.default None]
  ; args : Yojson.Safe.json option [@yojson.default None] }
[@@deriving make, to_yojson]

let build_args : _ -> Yojson.Safe.json option = function
  | None ->
      None
  | Some args ->
      Some (`Assoc args)

let complete ~name ~ts ~dur ?args ?color () =
  make ~ph:'X' ~name ~ts ~dur ?args:(build_args args) ?color ()

let duration_begin ~name ~ts ?args ?color () =
  make ~ph:'B' ~name ~ts ?args:(build_args args) ?color ()

let duration_end ~name ~ts ?args ?color () =
  make ~ph:'E' ~name ~ts ?args:(build_args args) ?color ()

let instant ~name ~ts ?args ?color () =
  make ~ph:'I' ~name ~ts ?args:(build_args args) ?color ()
