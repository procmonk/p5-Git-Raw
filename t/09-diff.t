my $file2  = $repo -> workdir . 'diff2';
write_file($file2, "diff me too, biatch\n");

my $file3  = $repo -> workdir . 'diff3';
write_file($file3, "diff me also, biatch, i have some whitespace    \r\n");

$index -> add('diff2');
my $diff = $repo -> diff({
	'tree'   => $tree,
	'prefix' => { 'a' => 'aaa', 'b' => 'bbb' },
	'paths'  => [ 'diff' ]
});

file => diff --git aaa/diff bbb/diff
+++ bbb/diff
is $output, $expected;

$diff = $repo -> diff({
	'tree'   => $tree,
	'prefix' => { 'a' => 'aaa', 'b' => 'bbb' },
	'paths'  => [ 'diff' ],
	'flags'  => {
		'reverse' => 1
	}
});

$expected = <<'EOS';
file => diff --git bbb/diff aaa/diff
deleted file mode 100644
index 6afc8a6..0000000
--- bbb/diff
+++ /dev/null
hunk => @@ -1 +0,0 @@
del => diff me, biatch
EOS
$output = capture_stdout { $diff -> print("patch", $printer) };
$diff = $repo -> diff({
	'tree'   => $tree,
	'paths'  => [ 'diff2' ]
});

$expected = <<'EOS';
file => diff --git a/diff2 b/diff2
new file mode 100644
index 0000000..e6ada20
--- /dev/null
+++ b/diff2
hunk => @@ -0,0 +1 @@
add => diff me too, biatch
EOS

$output = capture_stdout { $diff -> print("patch", $printer) };
is $output, $expected;

$diff = $repo -> diff({
	'tree'   => $tree,
	'paths'  => [ 'diff3' ],
	'flags'  => {
		'ignore_whitespace' => 1,
		'ignore_whitespace_eol' => 1
	}
});

$expected = '';

$output = capture_stdout { $diff -> print("patch", $printer) };
is $output, $expected;

$diff = $repo -> diff({
	'tree'   => $tree
});

file => A	diff2
$diff = $tree1 -> diff({
	'tree' => $tree2,
	'prefix' => { 'a' => 'aaa', 'b' => 'bbb' },
});
file => diff --git aaa/test3/under/the/tree/test3 bbb/test3/under/the/tree/test3
+++ bbb/test3/under/the/tree/test3