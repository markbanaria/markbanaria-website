module.exports = (grunt) ->

  # configuration
  grunt.initConfig

    # grunt sass
    sass:
      build:
        options:
          style: 'expanded'
        files: 
          'dist/css/style.css': 'app/stylesheets/style.sass',
          'dist/css/bootstrap.css': 'node_modules/bootstrap/dist/css/bootstrap.min.css'

    # grunt slim
    slim:
      build:
        files:
          'dist/index.html' : 'app/index.slim'

    # grunt concat
    concat:
      build:
        src: ['node_modules/jquery/dist/jquery.js', 'node_modules/bootstrap/dist/bootstrap.js', 'app/assets/javascripts/app.js'],
        dest: 'dist/js/app.js'  

    #grunt uglify
    uglify:
      build:
        files: 'dist/js/app.min.js' : 'dist/js/app.js'

    # grunt watch (or simply grunt)
    watch:
      html:
        files: ['**/*.html']
      sass:
        files: ['**/*.scss', '**/*.css', '**/*.sass']
        tasks: ['sass']
      slim:
        files: ['**/*.slim']
        tasks: ['slim']
      concat:  
        files: ['**/*.js']
        tasks: ['uglify']
      uglify:  
        files: ['**/*.js']
        tasks: ['uglify']
      options:
        livereload: true

    # grunt connect
    connect:
      server:
        options:
          base: 'dist'     

    # grunt gh-pages
    'gh-pages':
      options:
        base: 'dist'
      src: ['index.html']     

  # load plugins
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-slim'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-gh-pages'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-concat'

  # tasks
  grunt.registerTask 'default', ['concat', 'uglify', 'sass', 'slim', 'connect', 'watch']