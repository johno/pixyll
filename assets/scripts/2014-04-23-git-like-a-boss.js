// The dirty version (MP3s inside).
$( function () {
  var dirtyRepo = new GitGraph( {
    elementId: "dirty-repo",
    orientation: "vertical",
    template: "blackarrow",
    author: "Nicolas Carlo <nicolas.carlo@metidia.com>"
  } );

  var master = dirtyRepo.branch( "master" );
  master.commit( {
    sha1: "4f81107",
    message: "Add README.md"
  } );
  master.commit( {
    color: "red",
    dotColor: "red",
    message: "Add .mp3 files"
  } );
  master.commit( {
    sha1: "d528a17",
    message: "Update README.md"
  } );

  var develop = master.branch( "develop" );
  develop.commit( {
    sha1: "a17bc11",
    message: "Start another feature here."
  } );
  develop.commit( {
    sha1: "662bae",
    message: "Add some JS files"
  } );
  develop.commit( {
    sha1: "1ba328f",
    color: "red",
    dotColor: "red",
    message: "Update some tests + add more mp3 files"
  } );
  develop.commit( {
    color: "red",
    dotColor: "red",
    message: "Few mp3 again \\o/"
  } );

  master.commit( {
    sha1: "fe172b1",
    message: "Hotfix this typo!"
  } );

  develop.commit( {
    sha1: "3bcb329",
    message: "He doesn't like George Michael! Boooo!"
  } );
  develop.merge( master );

  master.commit( {
    sha1: "aa1b2e1",
    message: "Edit some files here"
  } );
} );

// The clean version (without MP3s).
$( function () {
  var cleanRepo = new GitGraph( {
    elementId: "clean-repo",
    orientation: "vertical",
    template: "blackarrow",
    author: "Nicolas Carlo <nicolascarlo.espeon@gmail.com>"
  } );

  var master = cleanRepo.branch( "master" );
  master.commit( {
    sha1: "4f81107",
    message: "Add README.md"
  } );
  master.commit( {
    sha1: "d528a17",
    message: "Update README.md"
  } );

  var develop = master.branch( "develop" );
  develop.commit( {
    sha1: "a17bc11",
    message: "Start another feature here."
  } );
  develop.commit( {
    sha1: "662bae",
    message: "Add some JS files"
  } );
  develop.commit( {
    sha1: "3491af2",
    message: "Update some tests + add more mp3 files"
  } );

  master.commit( {
    sha1: "fe172b1",
    message: "Hotfix this typo!"
  } );

  develop.commit( {
    sha1: "3bcb329",
    message: "He doesn't like George Michael! Boooo!"
  } );
  develop.merge( master );

  master.commit( {
    sha1: "aa1b2e1",
    message: "Edit some files here"
  } );
} );
