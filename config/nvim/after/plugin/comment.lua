local comment_ft = require "Comment.ft"
comment_ft.set("lua", { "--%s", "--[[%s]]" })

require 'todo-comments'.setup()
