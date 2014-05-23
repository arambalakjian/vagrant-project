/* global module */
module.exports = function (grunt) {
	'use strict';

	// Project configuration    
	// ----------------------------------------------/
	
	grunt.initConfig({

		pkg: grunt.file.readJSON('package.json'),

		config: {
			dest: {
				path: "public_html/mysite",
				scripts: {
					path: "<%= config.dest.path %>/js",
					vendor: {
						path: "<%= config.dest.scripts.path %>/vendor"
					}
				},
				styles: {
					path: '<%= config.dest.path %>/css'
				},
				templates: {
					path: '<%= config.dest.path %>/templates'
				},
				images: {
					path: '<%= config.dest.path %>/images'
				},
				fonts: {
					path: '<%= config.dest.path %>/fonts'
				}
			},
			src: {
				path: "theme_src",
				scripts: {
					path: '<%= config.src.path %>/scripts',
					coffeescript: {
						path: '<%= config.src.scripts.path %>/coffee'
					},
					javascript: {
						path: '<%= config.src.scripts.path %>/js'
					}
				},
				styles: {
					path: '<%= config.src.path %>/styles',
					less: {
						path: '<%= config.src.styles.path %>/less'
					},
					sass: {
						path: '<%= config.src.styles.path %>/sass'
					},
					css: {
						path: '<%= config.src.styles.path %>/css'
					}
				},
				templates: {
					path: '<%= config.src.path %>/templates'
				},
				images: {
					path: '<%= config.src.path %>/images'
				},
				fonts: {
					path: '<%= config.src.path %>/fonts'
				},
				temp: {
					path: '<%= config.src.path %>/tmp'
				}
			},
			vendor_scripts: {
				bootstrap: [
					'bower_components/bootstrap/js/affix.js',
					'bower_components/bootstrap/js/alert.js',
					'bower_components/bootstrap/js/button.js',
					'bower_components/bootstrap/js/carousel.js',
					'bower_components/bootstrap/js/collapse.js',
					'bower_components/bootstrap/js/dropdown.js',
					'bower_components/bootstrap/js/modal.js',
					'bower_components/bootstrap/js/tooltip.js',
					'bower_components/bootstrap/js/popover.js',
					'bower_components/bootstrap/js/scrollspy.js',
					'bower_components/bootstrap/js/tab.js',
					'bower_components/bootstrap/js/transition.js',
					'bower_components/bootstrap/js/transition.js'
				],
				modernizr: [
					'bower_components/modernizr/modernizr.js'
				]
			}
		},

		banner: '/*!\n' +
			' * <%= pkg.name %> Theme version: <%= pkg.version %>\n' +
			' * <%= pkg.description %>\n' +
			' * Copyright <%= grunt.template.today("yyyy") %> <%= pkg.author %> <%= pkg.url %>\n' +
			' * Distributed under the <%= pkg.license %> license\n' +
			' * <%= pkg.homepage %>\n' +
			' */\n',

		less: {
			dev:{
				options:{
					sourceMap: true,
					sourceMapFilename: "<%= config.dest.styles.path %>/core.css.map",
					sourceMapRootpath: "/"
				},
				files: {
					"<%= config.dest.styles.path %>/core.css": "<%= config.src.styles.less.path %>/core.less"
				}
			},
			dist: {
				options:{
					compress: true,
					cleancss: true
				},
				files: {
					"<%= config.dest.styles.path %>/core.min.css": "<%= config.dest.styles.path %>/core.css"
				}
			}
		},

		coffeelint: {
			app: ['<%= config.src.scripts.coffeescript.path %>/**/*.coffee']
		},

		coffee: {
			app: {
				options: {
					sourceMap: true
				},
				expand: true,
				flatten: true,
				cwd: '<%= config.src.scripts.coffeescript.path %>',
				src: ['*.coffee'],
				dest: '<%= config.src.scripts.javascript.path %>',
				ext: '.js'
			}
		},

		concat: {
			options:{
				separator: ';'
			},
			app: {
				options: {
					banner: '<%= banner %>'
				},

				/**
				 * List scripts to combine
				 */
				src: [
					'<%= config.src.scripts.javascript.path %>/functions.js',
					'<%= config.src.scripts.javascript.path %>/app.js'
				],

				dest: '<%= config.dest.scripts.path %>/<%= pkg.name %>.js'
			},
			bootstrap: {
				src: '<%= config.vendor_scripts.bootstrap %>',
				dest: '<%= config.dest.scripts.vendor.path %>/bootstrap.js'
			},
			modernizr: {
				src: '<%= config.vendor_scripts.modernizr %>',
				dest: '<%= config.dest.scripts.vendor.path %>/modernizr.js'
			}
		},

		jshint: {
			pre_concat: {
				src: ['<%= config.src.scripts.javascript.path %>/**/*.js']
			},
			post_concat: {
				src: ['<%= config.dest.scripts.path %>/<%= pkg.name %>.js']
			}
		},

		uglify: {
			app: {
				options: {
					sourceMap: true
				},
				src: '<%= config.dest.scripts.path %>/<%= pkg.name %>.js',
				dest: '<%= config.dest.scripts.path %>/<%= pkg.name %>.min.js'
			},
			bootstrap: {
				options: {
					title: 'Uglify',
					message: 'Conopnemts susescclfuly ugilfeid'
				},
				src: '<%= config.dest.scripts.vendor.path %>/bootstrap.js',
				dest: '<%= config.dest.scripts.vendor.path %>/bootstrap.min.js'
			},
			modernizr: {
				options: {
					title: 'Uglify',
					message: 'Conopnemts susescclfuly ugilfeid'
				},
				src: '<%= config.dest.scripts.vendor.path %>/modernizr.js',
				dest: '<%= config.dest.scripts.vendor.path %>/modernizr.min.js'
			}
		},

		imagemin: {
			options: {
				optimizationLevel: 3
			},
			dist: {
				files: [{
					expand: true,
					cwd: '<%= config.src.path %>/images',
					src: ['**/*.{png,jpg,gif}'],
					dest: '<%= config.dest.images.path %>'
				}]
			}
		},

		usebanner: {
			css: {
				options:{
					position: 'top',
					banner: '<%= banner %>'
				},
				files: {
					src: ['<%= config.dest.styles.path %>/core.min.css']
				}
			}
		},

		htmlmin: {
			templates: {
				options: {
					//conservativeCollapse: true,
					keepClosingSlash: true,
					removeComments: true,
					collapseWhitespace: true
				},
				files: [{
					expand: true,
					cwd: '<%= config.src.templates.path %>',
					src: ['**/*.ss'],
					dest: '<%= config.dest.templates.path %>'
				}]
			}
		},

		copy: {
			fonts: {
				files: [{
					expand: true,
					cwd: '<%= config.src.fonts.path %>',
					src: ['**/*.{eot,svg,ttf,woff}'],
					dest: '<%= config.dest.fonts.path %>'
				}]
			}
		},

		clean: [
			'<%= config.src.temp.path %>', 
			'<%= config.dest.styles.path %>',
			'<%= config.dest.fonts.path %>',
			'<%= config.dest.images.path %>',
			'<%= config.dest.scripts.path %>',
			'<%= config.dest.templates.path %>'
		],

		watch: {
			options: {
				livereload: 9000 // Vagrant using default port 35729
			},

			less: {
				options: {
					atBegin: true
				},

				files: ['<%= config.src.styles.less.path %>/**/*.less'],

				tasks: ['less']
			},

			imagemin: {

				files: ['<%= config.src.images.path %>/**/*.{png,gif,jpg}'],

				tasks: ['newer:imagemin']
			},

			coffee: {
				options: {
					livereload: false
				},
				files: ['<%= config.src.scripts.coffeescript.path %>/**/*.coffee'],

				tasks: ['newer:coffeelint', 'newer:coffee']
			},

			js: {
				files: ['<%= config.src.scripts.javascript.path %>/**/*.js'],

				tasks: ['newer:jshint:pre_concat', 'concat:app', 'jshint:post_concat', 'newer:uglify']
			},

			htmlmin: {
				options: {
					atBegin: true
				},
				files: ['<%= config.src.templates.path %>/**/*.ss'],
				tasks: ['newer:htmlmin']
			},

			fonts: {
				files: ['<%= config.src.fonts.path %>/**/*.{eot,svg,ttf,woff}'],
				tasks: ['newer:copy:fonts']
			}
		}
	});

	// Tasks
	// ----------------------------------------------/

	// Default task(s).
	grunt.registerTask('default', ['watch']);

	grunt.registerTask('build', [
		'imagemin', 
		'coffeelint', 
		'coffee', 
		'jshint:pre_concat', 
		'concat', 
		'uglify', 
		'less', 
		'htmlmin', 
		'copy'
	]);


	// Plugins - autoload each dev dependency
	// ----------------------------------------------/
	require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);
};