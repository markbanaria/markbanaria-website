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
          [
            {'dist/index.html' : 'app/index.slim'},
            {
              expand: true,
              cwd: 'app/pages',
              src: ['{,*/}*.slim'],
              dest: 'dist/pages',
              ext: '.html'
            }
          ] 

    #grunt uglify
    uglify:
      build:
        files: 'dist/js/app.min.js' : [
          'node_modules/jquery/dist/jquery.js', 
          'node_modules/bootstrap/dist/js/bootstrap.js',
          'node_modules/handlebars/dist/handlebars.js',
 
          'app/javascripts/data.js',  
          'app/javascripts/templates.js', 
          'app/javascripts/app.js'
        ]

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

    # grunt copy
    copy:
      main:
        expand: true,
        cwd: 'app/images',
        src: ['**/*.{png,jpg,gif,svg}'],
        dest: 'dist/images'      

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
  grunt.loadNpmTasks 'grunt-contrib-copy'

  # tasks
  grunt.registerTask 'default', ['uglify', 'sass', 'slim', 'connect', 'copy', 'watch']