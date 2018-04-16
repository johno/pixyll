// Blackarrow template solution to illustrate this library
$( function ( ) {
  var blackarrowSolution = new GitGraph( {
    elementId: "blackarrow-solution",
    orientation: "vertical",
    template: "blackarrow",
    author: "Nicolas Carlo <nicolascarlo.espeon@gmail.com>"
  } );

  var master = blackarrowSolution.branch( "master" );
  blackarrowSolution.commit( "This is a commit" ).commit( "And here's another one!" ).commit( );

  var develop = master.branch( "develop" );
  develop.commit( "My first commit on develop." );

  var feature = develop.branch( "feature" );
  feature.commit( "This is a mandatory feature" ).commit( ).commit( );
  develop.commit( "Meawhile, we commit on develop..." );
  feature.merge( develop, "Merged into develop" );
  feature.delete( );

  develop.commit( "Add some commit here..." ).commit( );
  develop.merge( master, "Here we merge!" );
  master.commit( ).commit( );
} );

// Metro template solution to illustrate this library
$( function ( ) {
  var metroSolution = new GitGraph( {
    elementId: "metro-solution",
    orientation: "horizontal"
  } );

  var master = metroSolution.branch( "master" );
  metroSolution.commit( ).commit( ).commit( );

  var develop = master.branch( "develop" );
  develop.commit( ).commit( );

  develop.merge( master, "Here we merge!" );
  master.commit( ).commit( );
} );
