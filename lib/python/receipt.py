# -*- coding: utf-8 -*-

def build(id):
    import weasyprint
    from weasyprint import HTML

    return HTML('http://app.davos.gives/receipts/{id}'.format(id=id)).write_pdf('temp/{id}.pdf'.format(id=id))
