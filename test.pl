# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';
# where last_test_to_print is the # of total tests

use Test;
BEGIN { plan tests => 3,
        onfail => sub { warn "*you* broke it $!" }
};

use Pod::Stripper;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

## dang cpan testers
chmod 0664, 'test.stripped' or die "can't chmod test.stripped? $!";

ok(&test1(),'1');
ok(&test2(),'1');

sub test1
{
    use Pod::Stripper;
    eval q{
        my $Stripper = new Pod::Stripper();
        $Stripper->parse_from_file('test.pl','test.stripped');
    };

    return $@ ? $@ : 1;
}


sub test2
{
    use Pod::Stripper;
    eval q{
        my $Stripper = new Pod::Stripper();
        open OUTSTRIPPED, '>>test.stripped' or die "test.stripped $!\n";
        $Stripper->parse_from_filehandle(\*DATA,\*OUTSTRIPPED);
    };

    return $@ ? $@ : 1;
}

__END__

=head1 THIS IS POINTLESS BUSY BODY POD

It is here for the TEEEEEEEEEEEEEST buddy

=cut

# this is non - pod