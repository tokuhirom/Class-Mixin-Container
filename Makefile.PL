use inc::Module::Install;
use Module::Install::AuthorTests;
use Module::Install::ReadmeMarkdownFromPod;

name 'Class-Mixin-Container';
all_from 'lib/Class/Mixin/Container.pm';
readme_markdown_from 'lib/Class/Mixin/Container.pm';

requires 'Sub::Exporter' => 0.982;

tests 't/*.t t/*/*.t t/*/*/*.t t/*/*/*/*.t';
test_requires 'Test::More' => 0.96; # done_testing, subtest
author_tests('xt');
WriteAll;
