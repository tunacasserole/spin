module.exports = function(grunt) {



    // Project configuration.

    grunt.initConfig({

        pkg: grunt.file.readJSON('package.json'),

        sass: { // Task

            dist: { // Target

                options: { // Target options

                    style: 'expanded'

                },

                files: [{

                    expand: true,

                    cwd: 'scss',

                    src: ['*.scss'],

                    dest: 'css',

                    ext: '.css'

                }]

            }

        },

        concat: {

            dist: {

                src: ['js/inc/**/*.js'],

                dest: 'js/concat.js',

            },

        },

        uglify: {

            options: {

                mangle: false

            },

            my_target: {

                files: {

                    'js/app.min.js': ['js/concat.js']

                }

            }

        },



        csssplit: {

            your_target: {

                src: ['css/app.css'],

                dest: 'css/app.css',

                options: {

                    maxSelectors: 4000,

                    suffix: '_'

                }

            },

        },

        cssmin: {

            options: {

                keepSpecialComments: 0

            },

            target: {

                files: {

                    'css/app_1.min.css': ['css/app_1.css'],

                    'css/app_2.min.css': ['css/app_2.css'],

                }

            }

        },

        copy: {

            main: {

                expand: true,

                cwd: '',

                src: [

                    "**/*",

                    '!**/node_modules/**',

                    '!**/.idea/**',

                    '!**/*.text**',

                    '!**/*.txt**',

                    '!**/.DS_Store**',

                    '!**/scss/**',

                    '!**/js/inc/**',

                    '!**/js/app.js**',

                    '!**/js/concat.js**',

                    '!**/package.json**',

                    '!**/gruntfile.js**',

                    '!**/css/inc/**',

                    '!**/css/app_1.css**',

                    '!**/css/app_2.css**',

                    '!**/css/app.css.map**',

                    '!**/css/app.css'

                ],

                dest: '../dist/'

            },

        },

        clean: ['**/.idea', '**/.DS_Store', 'dist'],

        watch: {

            sass: {

                files: ['scss/**/*.scss'], // which files to watch

                tasks: ['sass', 'csssplit', 'cssmin', 'dist']

            },

            js: {

                files: ['js/inc/**/*.js'], // which files to watch

                tasks: ['concat', 'uglify', 'dist']

            }



        }

    });



    // Load the plugin that provides the "less" task.

    grunt.loadNpmTasks('grunt-contrib-sass');

    grunt.loadNpmTasks('grunt-csssplit');

    grunt.loadNpmTasks('grunt-contrib-watch');

    grunt.loadNpmTasks('grunt-contrib-concat');

    grunt.loadNpmTasks('grunt-contrib-cssmin');

    grunt.loadNpmTasks('grunt-contrib-uglify');

    grunt.loadNpmTasks('grunt-contrib-copy');

    grunt.loadNpmTasks('grunt-contrib-clean');



    grunt.registerTask('dist', ['clean', 'copy']);

    grunt.registerTask('build', ['sass', 'csssplit', 'cssmin', 'concat', 'uglify', 'dist']);

    grunt.registerTask('default', ['build']);



};
