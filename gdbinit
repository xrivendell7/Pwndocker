# INSTALL INSTRUCTIONS: save as ~/.gdbinit
#
# DESCRIPTION: A user-friendly gdb configuration file, for x86/x86_64 and ARM platforms.
#
# REVISION : 8.0.5 (18/08/2013)
#
# CONTRIBUTORS: mammon_, elaine, pusillus, mong, zhang le, l0kit,
#               truthix the cyberpunk, fG!, gln
#
# FEEDBACK: http://reverse.put.as - reverser@put.as
#
# NOTES: 'help user' in gdb will list the commands/descriptions in this file
#        'context on' now enables auto-display of context screen
# # MAC OS X NOTES: If you are using this on Mac OS X, you must either attach gdb to a process
#                 or launch gdb without any options and then load the binary file you want to analyse with "exec-file" option
#                 If you load the binary from the command line, like $gdb binary-name, this will not work as it should
#                 For more information, read it here  
#
# UPDATE: This bug can be fixed in gdb source. Refer to http://reverse.put.as/2009/08/10/fix-for-apples-gdb-bug-or-why-apple-forks-are-bad/
#         and http://reverse.put.as/2009/08/26/gdb-patches/ (if you want the fixed binary for i386)
#
#         An updated version of the patch and binary is available at http://reverse.put.as/2011/02/21/update-to-gdb-patches-fix-a-new-bug/
#
# iOS NOTES: iOS gdb from Cydia (and Apple's) suffer from the same OS X bug.
#			 If you are using this on Mac OS X or iOS, you must either attach gdb to a process
#            or launch gdb without any options and then load the binary file you want to analyse with "exec-file" option
#            If you load the binary from the command line, like $gdb binary-name, this will not work as it should
#            For more information, read it here http://reverse.put.as/2008/11/28/apples-gdb-bug/
#
# CHANGELOG: (older changes at the end of the file)
#
#   Version 8.0.6 (05/09/2013)
#     - Add patch command to convert bytes to little-endian and patch memory
#
#   Version 8.0.5 (18/08/2013)
#     - Add commands header and loadcmds to dump Mach-O header information
#     - Other fixes and additions from previous commits
#
#   Version 8.0.4 (08/05/2013)
#     - Detect automatically 32 or 64 bits archs using sizeof(void*). 
#       Thanks to Tyilo for the simple but very effective idea!
#     - Typo in hexdump command also fixed by vuquangtrong.
#     - Add shortcuts to attach to VMware kernel debugging gdb stub (kernel32 and kernel64)
#
#   Version 8.0.3 (21/03/2013)
#	  - Add option to colorize or not output (thanks to argp and skier for the request and ideas!)
#     - Convert the escape codes into functions so colors can be easily customized
#	  - Other enhancements available at git commit logs
#       Thanks to Plouj, argp, xristos for their ideas and fixes!
#
#   Version 8.0.2 (31/07/2012)
#     - Merge pull request from mheistermann to support local modifications in a .gdbinit.local file
#     - Add a missing opcode to the stepo command
#
#   Version 8.0.1 (23/04/2012)
#     - Small bug fix to the attsyntax and intelsyntax commands (changing X86 flavor variable was missing)
#
#   Version 8.0 (13/04/2012)
#     - Merged x86/x64 and ARM versions
#     - Added commands intelsyntax and attsyntax to switch between x86 disassembly flavors
#     - Added new configuration variables ARM, ARMOPCODES, and X86FLAVOR
#     - Code cleanups and fixes to the indentation
#     - Bug fixes to some ARM related code
#     - Added the dumpmacho command to memory dump the mach-o header to a file
#
#   TODO:
#
# set debug-file-directory /usr/lib/debug

# __________________gdb options_________________

set disassembly-flavor intel
set print asm-demangle on
set history expansion on
set print asm-demangle on
set $ASM = 0

python

class IgnoreErrorsCommand (gdb.Command):

    def __init__ (self):
        super (IgnoreErrorsCommand, self).__init__ ("ignore-errors",
                                                    gdb.COMMAND_OBSCURE,
                                                    # FIXME...
                                                    gdb.COMPLETE_COMMAND)

    def invoke (self, arg, from_tty):
        try:
            gdb.execute (arg, from_tty)
        except:
            pass

IgnoreErrorsCommand ()
end
ignore-errors source ~/peda/peda.py
ignore-errors source ~/Pwngdb/pwngdb.py
ignore-errors source ~/Pwngdb/angelheap/gdbinit.py

define hook-run
python
import angelheap
angelheap.init_angelheap()
end

# set disassembly-flavor intel
#set output-radix 16

# prevent "Type <return> to continue"
#set height 0
# prevent line wrap
#set width 0

#handle SIGALRM nostop print nopass
#handle SIGBUS stop print nopass
#handle SIGPIPE nostop print nopass
#handle SIGSEGV stop print nopass

#set python print-stack full

# Bindings {{{1

# alias var=info variables

# define li
#   x/10i $pc

#end
#alias dd=disassemble

