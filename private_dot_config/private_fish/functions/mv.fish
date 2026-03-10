function mv --wraps mv --description "mv that creates destination directories automatically"
    if test (count $argv) -lt 2
        command mv $argv
        return
    end

    set dest $argv[-1]

    # If destination is not an existing directory, create its parent
    if not test -d $dest
        set parent (dirname $dest)
        mkdir -p $parent
    end

    command mv $argv
end
