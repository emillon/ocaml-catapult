type t [@@deriving to_yojson]

val complete :
     name:string
  -> ts:Mtime.t
  -> dur:Mtime.span
  -> ?args:(string * Yojson.Safe.json) list
  -> ?color:string
  -> unit
  -> t

val duration_begin :
     name:string
  -> ts:Mtime.t
  -> ?args:(string * Yojson.Safe.json) list
  -> ?color:string
  -> unit
  -> t

val duration_end :
     name:string
  -> ts:Mtime.t
  -> ?args:(string * Yojson.Safe.json) list
  -> ?color:string
  -> unit
  -> t

val instant :
     name:string
  -> ts:Mtime.t
  -> ?args:(string * Yojson.Safe.json) list
  -> ?color:string
  -> unit
  -> t
