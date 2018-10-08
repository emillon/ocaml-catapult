let case name f = (name, `Quick, f)

let yojson = Alcotest.testable Yojson.Safe.pretty_print ( = )

let test_to_yojson =
  let test event expected () =
    let got = Catapult.Event.to_yojson event in
    Alcotest.check yojson __LOC__ expected got
  in
  let ts = Mtime.of_uint64_ns 1000L in
  let dur = Mtime.Span.of_uint64_ns 2000L in
  let name = "name" in
  let color = "color" in
  let args = [("arg1", `String "arg1"); ("arg2", `String "arg2")] in
  [ case "duration_begin"
      (test
         (Catapult.Event.duration_begin ~name ~ts ())
         [%yojson {name = "name"; pid = 0; tid = 0; ph = "B"; ts = 1.}])
  ; case "duration_end"
      (test
         (Catapult.Event.duration_end ~name ~ts ())
         [%yojson {name = "name"; pid = 0; tid = 0; ph = "E"; ts = 1.}])
  ; case "complete"
      (test
         (Catapult.Event.complete ~name ~ts ~dur ())
         [%yojson
           {name = "name"; pid = 0; tid = 0; ph = "X"; ts = 1.; dur = 2.}])
  ; case "complete with all optional args"
      (test
         (Catapult.Event.complete ~name ~ts ~dur ~color ~args ())
         [%yojson
           { name = "name"
           ; pid = 0
           ; tid = 0
           ; ph = "X"
           ; ts = 1.
           ; dur = 2.
           ; color = "color"
           ; args = {arg1 = "arg1"; arg2 = "arg2"} }])
  ; case "instant"
      (test
         (Catapult.Event.instant ~name ~ts ())
         [%yojson {name = "name"; pid = 0; tid = 0; ph = "I"; ts = 1.}]) ]

let tests = [("to_yojson", test_to_yojson)]

let () = Alcotest.run "Catapult" tests
