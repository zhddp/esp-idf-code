#
# Internal file for GetGitRevisionDescription.cmake
#
# Requires CMake 2.6 or newer (uses the 'function' command)
#
# Original Author:
# 2009-2010 Ryan Pavlik <rpavlik@iastate.edu> <abiryan@ryand.net>
# http://academic.cleardefinition.com
# Iowa State University HCI Graduate Program/VRAC
#
# Copyright Iowa State University 2009-2010.
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)

set(HEAD_HASH)

file(READ "E:/Git-category/Git-Arduino/esp-idf-code/blink/blink/build/CMakeFiles/git-data/HEAD" HEAD_CONTENTS LIMIT 1024)

string(STRIP "${HEAD_CONTENTS}" HEAD_CONTENTS)
set(GIT_DIR "E:/work-data/IDF/v5.5/esp-idf/.git")
# handle git-worktree
if(EXISTS "${GIT_DIR}/commondir")
	file(READ "${GIT_DIR}/commondir" GIT_DIR_NEW LIMIT 1024)
	string(STRIP "${GIT_DIR_NEW}" GIT_DIR_NEW)
	if(NOT IS_ABSOLUTE "${GIT_DIR_NEW}")
		get_filename_component(GIT_DIR_NEW ${GIT_DIR}/${GIT_DIR_NEW} ABSOLUTE)
	endif()
	if(EXISTS "${GIT_DIR_NEW}")
		set(GIT_DIR "${GIT_DIR_NEW}")
	endif()
endif()
if(HEAD_CONTENTS MATCHES "ref")
	# named branch
	string(REPLACE "ref: " "" HEAD_REF "${HEAD_CONTENTS}")
	if(EXISTS "${GIT_DIR}/${HEAD_REF}")
		configure_file("${GIT_DIR}/${HEAD_REF}" "E:/Git-category/Git-Arduino/esp-idf-code/blink/blink/build/CMakeFiles/git-data/head-ref" COPYONLY)
	elseif(EXISTS "${GIT_DIR}/logs/${HEAD_REF}")
		configure_file("${GIT_DIR}/logs/${HEAD_REF}" "E:/Git-category/Git-Arduino/esp-idf-code/blink/blink/build/CMakeFiles/git-data/head-ref" COPYONLY)
		set(HEAD_HASH "${HEAD_REF}")
	endif()
else()
	# detached HEAD
	configure_file("${GIT_DIR}/HEAD" "E:/Git-category/Git-Arduino/esp-idf-code/blink/blink/build/CMakeFiles/git-data/head-ref" COPYONLY)
endif()

if(NOT HEAD_HASH)
	file(READ "E:/Git-category/Git-Arduino/esp-idf-code/blink/blink/build/CMakeFiles/git-data/head-ref" HEAD_HASH LIMIT 1024)
	string(STRIP "${HEAD_HASH}" HEAD_HASH)
endif()
