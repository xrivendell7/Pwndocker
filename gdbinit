set disassembly-flavor intel
set print asm-demangle on
set history expansion on
set print asm-demangle on
set python print-stack full
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

#Multiarch use original pwndbg
#ignore-errors source /pwndbg/gdbinit.py

define hook-run
python
import angelheap
angelheap.init_angelheap()
end
end




