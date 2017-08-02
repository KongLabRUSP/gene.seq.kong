### Project: TRAMP MeDIP-seq Data Analysis 
### Scientists: Wenji Li,  Davit Sargsyan

---

### Objectives

### Design
* Wild Type vs. TRAMP mice    
* DMA methylation at 24 weeks    

### Daily Logs
### 08/01/2017
* Imported data from an Excel sheet 'tramp_peaks_anno_cpg.csv', originally from an Excel file of the same name.    
* Used variables:    
1. **mgi_symbol**: gene name   
2. **gene_id**: a unique region of a gene    
3. **insideFeature**: is the location relative to genes: upstream ('promoter'), inside, or downstream ('body')    
4. **value_1**: values from the wildtype mice at 24 weeks ('C57_24wks')    
5. **value_2**: values from the TRAMP mice at 24 weeks ('Tramp_24wks') 
6. **log2_fold_change**: log2(TRAMP/C57)    
7. **description**: gene description

* Remove rows if:   
1. they are not mapped (no gene name) or    
2. one or both values are zero or    
3. foldcahnge is less than two    

From: WENJI LI <wl365@scarletmail.rutgers.edu>
Date: Thu, Jul 27, 2017 at 12:18 PM
Subject: Re: TRAMP MeDIP-seq
To: Ah-ng Kong <kongt@pharmacy.rutgers.edu>
Cc: Davit Sargsyan <sargdavid@gmail.com>, WENJI LI <wl365@scarletmail.rutgers.edu>

### From Wenji's Email
Dear Davit

Please kindly find the attached ms draft for TRAMP MeDIP-Seq. Please let me know your available time for discussion. Thanks a lot.

Best Regards,
Wenji 

---

On Thu, Jul 27, 2017 at 11:41 AM, WENJI LI wrote:
Dear Prof. Kong

John pointed out some limitations in last lab meeting and we halted the re-submission to Life Sciences. I think it is a good idea to submit it to Cell & Biosciences since limitations exist in all methods. I will contact Davit about the ms. Thanks.

Best Regards,
Wenji

---

On Thu, Jul 27, 2017 at 11:09 AM, Ah-ng Kong wrote:
Dear Wenji - did we go back to reanalyze the TRAMP MeDIP-seq data and may be we could send out for publication in Cell Biosciences? May be Davit can help to take a look? Tony

Epigenetic alterations in TRAMP mice: genomic DNA methylation profiling using MeDIP-seq? by Wenji Li, Ying Huang, Tin Oo Khor, Guo Yue, Limin Shu, Anne Yuqing Yang, Chengyue Zhang, Michael Verzi, Ronald P Hart, and Ah-Ng Tony Kong (publication #3).

like other cancers, arises from epigenetic modifications as well as genomic alterations (5, 6). We have conducted methylated DNA immunoprecipitation (MeDIP) with next- generation sequencing (MeDIP-seq) followed by Ingenuity Pathway Analysis to analyze and compare the whole genomic DNA methylation patterns between TRAMP tumors and control prostates from WT (C57BL/6) mice. The results from this study have been submitted for publication and tentatively acceptable for publication with revision in Life Sciences, ?Epigenetic alterations in TRAMP mice: genomic DNA methylation profiling using MeDIP-seq? by Wenji Li, Ying Huang, Tin Oo Khor, Guo Yue, Limin Shu, Anne Yuqing Yang, Chengyue Zhang, Michael Verzi, Ronald P Hart, and Ah-Ng Tony Kong (publication #3). The results from this study show that abnormal methylation status in CpG islands of a variety of genes in TRAMP tumors.

A.-N. Tony Kong, Ph.D.