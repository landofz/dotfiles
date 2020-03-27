import subprocess
from os.path import relpath, dirname

from deoplete.source.base import Base
from deoplete.util import Nvim, UserContext, Candidates


class Source(Base):

    def __init__(self, vim: Nvim) -> None:
        super().__init__(vim)

        self.name = 'zettel'
        self.mark = '[CL]' # crosslink
        self.min_pattern_length = 0
        self.rank = 450
        self.filetypes = ['asciidoc']

    def get_complete_position(self, context: UserContext) -> int:
        pos = context['input'].rfind('<<')
        return pos if pos < 0 else pos + 2

    def gather_candidates(self, context: UserContext) -> Candidates:
        cur_file_dir = dirname(self.vim.buffers[context['bufnr']].name)
        res = subprocess.run(['fd', '\.adoc$', cur_file_dir], stdout=subprocess.PIPE)
        return [relpath(f, cur_file_dir) for f in res.stdout.decode('utf-8').splitlines()]
