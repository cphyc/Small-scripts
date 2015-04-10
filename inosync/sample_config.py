# directory that should be watched for changes
wpaths = ["/home/ccc/Documents"]

# exclude list for rsync
rexcludes = [
    ".git/",
    ".svn/",
    "*.vdi",
    "node_modules/*",
    "bower_components/*",
]

# rpaths has one-to-one correspondence with wpaths for syncing multiple directories
rpaths = ["/home/cphyc/bkp/Documents"]

# remote locations in rsync syntax
rnodes = [
    "cphyc@cphyc.me:",
]

# extra, raw parameters to rsync
#extra = "--rsh=ssh -a"

# limit remote sync speed (in KB/s, 0 = no limit)
#rspeed = 0

# event mask (only sync on these events)
#emask = [
#	"IN_CLOSE_WRITE",
#	"IN_CREATE",
#	"IN_DELETE",
#	"IN_MOVED_FROM",
#	"IN_MOVED_TO",
#]

# event delay in seconds (prevents huge amounts of syncs, but dicreases the
# realtime side of things)
edelay = 10

# rsync log file for updates
logfile = "/home/username/inosync.log"

# rsync binary path
#rsync = "/usr/bin/rsync"
