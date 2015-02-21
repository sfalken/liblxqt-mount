#
# Write a pkg-config pc file for given "name" with "decription"
# Arguments:
#   name: a library name (withoud "lib" prefix and "so" suffixes
#   desc: a desription string
#
macro (create_pkgconfig_file name desc)
    set(_pkgfname "${CMAKE_CURRENT_BINARY_DIR}/${name}.pc")
    #message(STATUS "${name}: writing pkgconfig file ${_pkgfname}")

    file(WRITE "${_pkgfname}"
            "# file generated by LXQt cmake build\n"
            "prefix=${CMAKE_INSTALL_PREFIX}\n"
	    "libdir=${CMAKE_INSTALL_FULL_LIBDIR}\n"
	    "includedir=${LXQTMOUNT_INCLUDE_DIR}\n"
            "\n"
            "Name: ${name}\n"
            "Description: ${desc}\n"
            "Version: ${LXQT_VERSION}\n"
            "Libs: -L\${libdir} -l${name}\n"
            "Cflags: -I\${includedir}\n"
            "\n"
    )

    # FreeBSD loves to install files to different locations
    # http://www.freebsd.org/doc/handbook/dirstructure.html
    if(${CMAKE_SYSTEM_NAME} STREQUAL "FreeBSD")
        install(FILES ${_pkgfname} DESTINATION libdata/pkgconfig)
    else()
        install(FILES ${_pkgfname} DESTINATION lib${LIB_SUFFIX}/pkgconfig)
    endif()

endmacro()
