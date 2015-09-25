# See bottom of file for default license and copyright information
package Foswiki::Plugins::DocumentViewerPlugin;

use strict;
use warnings;

use Foswiki::Func    ();    # The plugins API
use Foswiki::Plugins ();    # For the API version

our $VERSION = '1.00';
our $RELEASE = '17 Aug 2015';
our $SHORTDESCRIPTION =
  'Embed presentations, spreadsheets, PDFs and other documents';
our $NO_PREFS_IN_TOPIC = 1;

sub initPlugin {
    my ( $topic, $web, $user, $installWeb ) = @_;

    # check for Plugins.pm versions
    if ( $Foswiki::Plugins::VERSION < 2.3 ) {
        Foswiki::Func::writeWarning( 'Version mismatch between ',
            __PACKAGE__, ' and Plugins.pm' );
        return 0;
    }

    Foswiki::Func::registerTagHandler( 'DOCUMENTVIEWER', \&_DOCUMENTVIEWER );

    return 1;
}

sub _DOCUMENTVIEWER {
    my ( $session, $params, $topic, $web, $topicObject ) = @_;

    # $session  - a reference to the Foswiki session object
    #             (you probably won't need it, but documented in Foswiki.pm)
    # $params=  - a reference to a Foswiki::Attrs object containing
    #             parameters.
    #             This can be used as a simple hash that maps parameter names
    #             to values, with _DEFAULT being the name for the default
    #             (unnamed) parameter.
    # $topic    - name of the topic in the query
    # $web      - name of the web in the query
    # $topicObject - a reference to a Foswiki::Meta object containing the
    #             topic the macro is being rendered in (new for foswiki 1.1.x)

    my $attachment = $params->{_DEFAULT};
    if ( !$attachment ) {
        return
'<noautolink><span class="foswikiAlert">DocumentViewerPlugin error: Missing parameter to DOCUMENTVIEWER</span></noautolink>';
    }
    ( $web, $topic ) =
      Foswiki::Func::normalizeWebTopicName( $params->{web} || $web,
        $params->{topic} || $topic );

    unless ( Foswiki::Func::attachmentExists( $web, $topic, $attachment ) ) {
        return
'<noautolink><span class="foswikiAlert">DocumentViewerPlugin error: Attachment does not exist</span></noautolink>';
    }
    my $path = Foswiki::Func::getPubUrlPath( $web, $topic, $attachment );

    my $viewer =
      Foswiki::Func::getPubUrlPath( 'System', 'DocumentViewerPlugin',
        'ViewerJS/index.html' );

    my $url = $viewer . '#' . $path;

    my $format = $params->{format} || '';
    my ( $width, $height );

    if ( $format eq 'portrait' ) {
        $width  = 724;
        $height = 1024;
    }
    elsif ( $format eq 'landscape' ) {
        $width  = 1024;
        $height = 724;
    }
    elsif ( $format eq 'screen' ) {
        $width  = 1024;
        $height = 768;
    }
    else {
        $width  = $params->{width}  || 724;
        $height = $params->{height} || 1024;
    }

    return
qq(<iframe src="$url" width="$width" height="$height" allowfullscreen webkitallowfullscreen></iframe>);
}

1;

__END__
Foswiki - The Free and Open Source Wiki, http://foswiki.org/

Copyright (C) 2015 Foswiki Contributors. Foswiki Contributors
are listed in the AUTHORS file in the root of this distribution.
NOTE: Please extend that file, not this notice.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version. For
more details read LICENSE in the root of this distribution.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

As per the GPL, removal of this notice is prohibited.
