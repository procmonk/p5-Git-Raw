$repo -> config -> bool('diff.mnemonicprefix', 0);

add => diff me, biatch
my $output = capture_stdout { $diff -> print("patch", $printer) };
$output = capture_stdout { $diff -> print("name_status", $printer) };
add => this is a third testdel => 
$output = capture_stdout { $diff -> print("patch", $printer) };
$output = capture_stdout { $diff -> print("name_status", $printer) };