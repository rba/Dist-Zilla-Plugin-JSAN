use strict;
use warnings;
use Test::More 0.88;

use lib 't/lib';

use Path::Class;
use JSON 2;

use Test::DZil;

{
    $ENV{JSANLIB} = dir('test_data', 'Bundle', 'jsan')->absolute() . '';
    
    my $tzil = Dist::Zilla::Tester->from_config(
        { dist_root => 'test_data/Bundle' },
    );

    $tzil->build;
    
    my $digest5_content = $tzil->slurp_file(file(qw(build lib Digest MD5.js))) . "";
    my $digest6_content = $tzil->slurp_file(file(qw(build lib Digest MD6.js))) . "";
    
    ok($digest5_content =~ /VERSION : 0.01,/, 'Correctly embedded version #1');
    ok($digest6_content =~ /VERSION : 0.01(?!,)/, 'Correctly embedded version #2');
}

done_testing;
