from random import *
from random import shuffle
from numpy import *
from itertools import *
import os
import tabix

from optparse import OptionParser
parser = OptionParser()
parser.add_option("-v", "--vcf", dest="vcf", help="VCF.gz, tabixed", default="")
parser.add_option("-d", "--dir", dest="dir", help="input directory", default="")
parser.add_option("-D", "--outdir", dest="outdir", help="output directory", default="")
parser.add_option("-f", "--foc", dest="foc", help="focal population list of names in vcf header", default="")
parser.add_option("-c", "--chr", dest="chr", help="chromosome", default="")
parser.add_option("-s", "--st", dest="st", help="start coordinate", default="")
parser.add_option("-e", "--end", dest="end", help="end coordinate", default="")
parser.add_option("-n", "--num", dest="num", help="interval number (line number from intervals file)", default="")

(options, args) = parser.parse_args()

##########
for line in open('/netscratch/dep_mercier/grp_novikova/Fragaria/new_map/header'):
	if '#CHR' in line:
		names=line.strip().split()
                print (names[126],names[103])
names=[]
foc=[]
for line in open('%s/%s'%(options.dir, options.foc), 'r'):
        foc.append(line.strip())

names,foc=array(names),array(foc)

foc_ind=in1d(names,foc)
####outgroup1 - column number 127 sample 183
####outgroup2 - columnn number 104 sample 184

out=open('%s/%s.input'%(options.outdir, options.num), 'w')
chr,st,end=options.chr,int(options.st),int(options.end)

bad=['./.', './././.', './././././././././.', './././././.','./././././././././././.', './././././././.' ]

tb1 = tabix.open('%s/%s'%(options.dir,options.vcf))
records = tb1.query(chr, st, end)
for record in records:
    ref,alt=record[3],record[4]
    if len(ref)==1 and len(alt)==1 and ref!='*' and alt!='*':
        record=array(record)
        focal_gen=list(record[foc_ind])
        focal_gen_f=[x for x in focal_gen if x not in bad]
        out1,out2=record[126],record[103]
        if len(focal_gen_f)==len(focal_gen) and out1[0]!='.' and out2[0]!='.':
            focal_gen=[x for x in '/'.join(focal_gen)[::2]]
            out1,out2=[x for x in out1[::2]],[x for x in out2[::2]]
            if len(set(focal_gen+out1+out2))==2:
                focal_gen=[ref if x=='0' else alt for x in focal_gen]
                out1,out2=[ref if x=='0' else alt for x in out1],[ref if x=='0' else alt for x in out2]
                out.write('%i,%i,%i,%i %i,%i,%i,%i %i,%i,%i,%i\n'%(focal_gen.count('A'), focal_gen.count('C'), focal_gen.count('G'), focal_gen.count('T'), out1.count('A'), out1.count('C'), out1.count('G'), out1.count('T'), out2.count('A'), out2.count('C'), out2.count('G'), out2.count('T')))

out.close()

