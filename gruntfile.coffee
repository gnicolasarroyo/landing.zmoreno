module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    
    meta:
      build_path   : 'build'
      assets_path  : 'www/assets',
      banner       : '/* <%= pkg.name %> v<%= pkg.version %> - <%= grunt.template.today("yyyy/m/d") %>\n' +
                     '   <%= pkg.homepage %>\n' +
                     '   Copyright (c) <%= grunt.template.today("yyyy") %> */\n'
      
    source:
      bower_css: [
        'bower_components/bootstrap/dist/css/bootstrap.min.css'
      ]
      bower_js: [
        'bower_components/jquery/dist/jquery.min.js'
        'bower_components/bootstrap/dist/js/bootstrap.min.js'
      ]
      stylus: [
        'src/style/font.styl'
        'src/style/header.styl'
        'src/style/section.styl'
        'src/style/footer.styl'
      ]
    
    concat:
      base_css : files : '<%= meta.assets_path %>/css/<%= pkg.name %>.base.min.css' : '<%= source.bower_css %>'
      base_js  : files : '<%= meta.assets_path %>/js/<%= pkg.name %>.base.min.js'   : '<%= source.bower_js %>'
      stylus   : files : '<%= meta.build_path %>/<%= pkg.name %>.styl'              : '<%= source.stylus %>'
      #coffee   : files : '<%= meta.build_path %>/<%= pkg.name %>.coffee' : '<%= source.coffee %>'
      
    stylus:
      app:
        files: '<%= meta.build_path %>/<%= pkg.name %>.min.css' : '<%= meta.build_path %>/<%= pkg.name %>.styl'
        
    #coffee:
    #  app: 
    #    files: '<%= meta.build_path %>/<%= pkg.name %>.js' : '<%= meta.build_path %>/<%= pkg.name %>.coffee'
    
    #uglify:
    #  options: 
    #    banner: "<%= meta.banner %>"
    #  css:
    #    files: '<%= meta.assets_path %>/css/<%= pkg.name %>.min.css' : '<%= meta.build_path %>/<%= pkg.name %>.css'
    #  js: 
    #    files: '<%= meta.assets_path %>/js/<%= pkg.name %>.min.js'   : '<%= meta.build_path %>/<%= pkg.name %>.js'
      
    copy:
      font:
        expand: true
        cwd: 'bower_components/bootstrap/dist/fonts/'
        src: '*' 
        dest: '<%= meta.assets_path %>/fonts/'
      css:
        expand: true
        cwd: '<%= meta.build_path %>/'
        src: '<%= pkg.name %>.min.css' 
        dest: '<%= meta.assets_path %>/css/'
        
    watch:
      #coffee:
      #  files: ['<%= source.coffee %>']
      #  tasks: ['concat:app', 'coffee:app', 'uglify:app', 'notify:coffee']
      stylus:
        files: ['<%= source.stylus %>']
        tasks: ['concat:stylus', 'stylus:app', 'copy:css']
        
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-notify'
  
  grunt.registerTask 'default', ['concat:base_js', 'concat:base_css', 'concat:stylus', 'stylus:app', 'copy:font', 'copy:css']