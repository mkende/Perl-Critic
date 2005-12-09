#######################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/trunk/Perl-Critic/lib/Perl/Critic/Policy/InputOutput/ProhibitBacktickOperators.pm $
#     $Date: 2005-12-06 23:30:07 -0800 (Tue, 06 Dec 2005) $
#   $Author: thaljef $
# $Revision: 79 $
########################################################################

package Perl::Critic::Policy::References::RequireCircumfixDereferences;

use strict;
use warnings;
use Perl::Critic::Utils;
use Perl::Critic::Violation;
use base 'Perl::Critic::Policy';

our $VERSION = '0.13_01';
$VERSION = eval $VERSION;    ## no critic

#----------------------------------------------------------------------------

my $expl = q{Double-sigil dereference};
my $desc = [ 456 ];

#----------------------------------------------------------------------------

sub default_severity { return $SEVERITY_LOW }
sub applies_to { return 'PPI::Token::Cast' }

#----------------------------------------------------------------------------

sub violates {
    my ( $self, $elem, $doc ) = @_;
    return if $elem eq q{\\};

    my $sib = $elem->snext_sibling || return;
    if ( ! $sib->isa('PPI::Structure::Block') ) {
        return Perl::Critic::Violation->new( $desc,
                                             $expl,
                                             $elem->location(),
                                             $self->get_severity(), );
    }
    return; #ok!
}

1;

__END__

#----------------------------------------------------------------------------

=pod

=head1 NAME

Perl::Critic::Policy::References::RequireCircumfixDereferences

=head1 DESCRIPTION

=head1 AUTHOR

Jeffrey Ryan Thalhammer <thaljef@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2005 Jeffrey Ryan Thalhammer.  All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.  The full text of this license
can be found in the LICENSE file included with this module.

=cut
