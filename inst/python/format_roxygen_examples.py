start = "#'"

def add_dontrun(doc):
    if "#' @examples" in doc:
        ex_start = doc.index(f"{start} @examples")
        ex_end = doc[ex_start+1:].index("{start} @")
        examples = doc[ex_start:ex_end]
        examples.prepend(f"{start} \dontrun{{")
        examples.append(f"{start} }}")
    new_doc = doc[:ex_start] + examples
    return new_doc

def edit_docs(lines):
    for line in lines:
        pass # TODO