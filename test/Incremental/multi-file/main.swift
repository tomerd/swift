// UNSUPPORTED: OS=windows-msvc
// 'find' trick is non-portable...

// RUN: %empty-directory(%t)
// RUN: %{python} %S/../gen-output-file-map.py -o %t %S/Inputs
// RUN: find %S -name "*.swift" > %t/Sources.resp
// RUN: cd %t && %target-swiftc_driver -typecheck -output-file-map %t/output.json -incremental -module-name main -verify-incremental-dependencies @%t/Sources.resp
// RUN: cd %t && %target-swiftc_driver -typecheck -output-file-map %t/output.json -incremental -enable-batch-mode -module-name main -verify-incremental-dependencies @%t/Sources.resp

// N.B. These tests are meant to continue to expand to more and more input files
// as more kinds of cross-type dependencies are discovered. This will naturally
// increase the chance that input ordering bugs will be surfaced by batch mode.