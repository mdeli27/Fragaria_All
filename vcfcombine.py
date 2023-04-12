for i in open("/netscratch/dep_mercier/grp_novikova/Fragaria/new_map/Fragaria_final.GT.vcf.gz.colnames.vesca"):
       i=i.strip()
       print("\t--variant ${vcf}/%s.g.vcf.gz \ "%(i))

