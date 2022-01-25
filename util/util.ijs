coclass'jaf'

NB. get c header file names and contents
getincs=: 3 : 0
select. UNAME
case. 'Linux' do.
 t=. '/opt/arrayfire/include' NB. path to af includes
case. 'Win'   do.
 t=. jpath (getenv'AF_PATH'),'/include' NB. path to af includes
case.         do.
 t=. 'path to af incluees ???'
end.
afincpath=: t
incfiles=: {."1 dirtree afincpath
inclines=: fread each incfiles
i.0 0
)

NB. create proto.txt famcnts.txt from c include files
getproto=: 3 : 0
if. _1=nc<'incfiles' do. getincs'' end.
start=. 'AFAPI af_err af_'
r=. ''
for_i. i.#incfiles do.
 t=. <;._2 ;i{inclines
 t=. deb each t
 a=. (<start)E.each t
 f=. ;+./each a
 q=. f#i.#t
 for_j. q do.
  d=. ;j{t
  while. -.')'e. d do. NB. continue til we see closing )
   j=. 1+j
   d=. d,;j{t NB. additional lines until closing )
  end.
  r=. r,<d
 end. 
end.
r=. (_3+#start)}.each r
assert (#r)=+/;(<');')-:each _2{.each r
r=. _1}.each r NB. losetrailing ;
r=. r rplc each <' (';'(' NB. lose blank before (
r=. /:~r
(;r,each LF)fwrite JAFP,'util/proto.txt'
i=. r i.each'('
n=. i{.each r
p=. i}.each r
b=. =p
c=. +/"1 b
i=. \:c
j=. b i."1[ 1
q=. (i{j){n
t=. (i{c) i. 1
d=. ;(t{.3":each i{c),each ' ',each (t{.q),each LF
d fwrite JAFP,'util/famcnts.txt'
i.0 0
)

NB. families handled by common routine
families=: ;:'af_abs af_add af_is_bool af_accum af_all_true_all'
fops=:     ;:'mop    dop    is         reduce   reduce_all'

NB. create families.ijs file from proto.txt and families/fops
genfamilies=: 3 : 0
defs=. 'coclass ''jaf''',LF
r=. <;._2 fread JAFP,'util/proto.txt'
i=. r i.each '('
n=. i{.each r
p=. i}.each r
for_i. i.#families do. 
 d=. (n i. i{families){p
 ns=. (p=d)#n
 a=. (ns,each <'=: '),each'''',each ns,each <'''',(;i{fops),']'
 defs=. defs,LF,;a,each LF
end.
defs fwrite JAFP,'families.ijs'
i.0 0
)
