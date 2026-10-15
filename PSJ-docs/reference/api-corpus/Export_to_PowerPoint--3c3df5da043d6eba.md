# Export to PowerPoint

Export to PowerPoint

🎯 Introduction​

In this tutorial, you'll learn how to export a simple report (pptx - Powerpoint format) by using python-pptx library with PSJ:

Read the model information (part ID, part name, number of nodes, elements, faces, edges, etc.).

Make a table comparing the above information.

Append the content to a PowerPoint file with pre-defined template:
First slide: title with created date.

Second slide: model information table.

📖 Tutorial​

# Encoding for Japanese
# coding: cp932

import JPT
from pptx.enum.text import PP_ALIGN
from os.path import isfile, isdir
from pptx import Presentation
from pptx.util import Inches
from pptx.util import Pt
from pptx.enum.text import MSO_ANCHOR
from datetime import datetime
import re

# Change your template and output folder here
template_file = r"C:\Users\USERNAME\Documents\template\template_report.pptx"
output_folder = r"C:\Users\USERNAME\Documents\template"

def export_report(template_file = "", output_folder = "", num_of_cols = 8):

    if isfile(template_file) and isdir(output_folder):
        # Output report file
        template_file = re.sub(re.escape("\\"), "/", template_file)
        output_pptx_file = re.sub(re.escape("\\"), "/", output_folder + "/" + "modal_infor_report.pptx")

        # Open template report and store it to a parameter
        ppt_report = Presentation(template_file)

        # Create the first slide (Title slide)
        title_slide = ppt_report.slides.add_slide(ppt_report.slide_layouts[0])
        title_slide.shapes.title.text = "EXAMPLE FOR EXPORTING MODAL INFORMATION"
        title_slide.placeholders[1].text = "Created: " + \
                                           str(datetime.now().year) + \
                                           "." + \
                                           str(datetime.now().month) + \
                                           "." + \
                                           str(datetime.now().day)

        # Create the 2nd slide (Modal info slide)
        slide = ppt_report.slides.add_slide(ppt_report.slide_layouts[4])
        slide.shapes.title.text = "MODAL INFORMATION"

        x, y, cx, cy = Inches(0.5), Inches(1.2), Inches(10), Inches(2)
        table = slide.shapes.add_table(len(JPT.GetAllParts()) + 2, num_of_cols, x, y, cx, cy).table
        table.cell(0, 0).merge(table.cell(0, num_of_cols - 1))
        table.cell(0, 0).text = "Modal information"
        table.cell(1, 0).text = "Part ID"
        table.cell(1, 1).text = "Part Name"
        table.cell(1, 2).text = "No. of Faces"
        table.cell(1, 3).text = "No. of Edges"
        table.cell(1, 4).text = "No. of Elements"
        table.cell(1, 5).text = "No. of Nodes"
        table.cell(1, 6).text = "Range of Node ID"
        table.cell(1, 7).text = "Range of Element ID"

        table.columns[0].width = Inches(1.2)
        table.columns[1].width = Inches(1.9)
        table.columns[2].width = Inches(1.2)
        table.columns[3].width = Inches(1.2)
        table.columns[4].width = Inches(1.5)
        table.columns[5].width = Inches(1.5)
        table.columns[6].width = Inches(1.9)
        table.columns[7].width = Inches(1.9)

        if len(JPT.GetAllParts()):
            for row, part in enumerate(JPT.GetAllParts()):
                table.cell(row + 2, 0).text = str(part.id)
                table.cell(row + 2, 1).text = part.name
                table.cell(row + 2, 2).text = str(len(part.faces))
                table.cell(row + 2, 3).text = str(len(part.edges))
                table.cell(row + 2, 4).text = str(len(part.elems))
                table.cell(row + 2, 5).text = str(len(part.nodes))
                table.cell(row + 2, 6).text = "Max: " + \
                                              str(max([_.id for _ in part.nodes])) + \
                                              "\n" + \
                                              "Min: " + \
                                              str(min([_.id for _ in part.nodes]))
                table.cell(row + 2, 7).text = "Max: " + \
                                              str(max([_.id for _ in part.elems])) + \
                                              "\n" + \
                                              "Min: " + \
                                              str(min([_.id for _ in part.elems]))
                table.rows[row].height = Inches(0.53)

        for row in table.rows:
            for cell in row.cells:
                cell.vertical_anchor = MSO_ANCHOR.MIDDLE
                for paragraph in cell.text_frame.paragraphs:
                    paragraph.alignment = PP_ALIGN.CENTER
                    for run in paragraph.runs:
                        run.font.size = Pt(13)
                        run.font.name = "MS UI Gothic"

        ppt_report.save(output_pptx_file)

        print(" FINISHED ".center(100, "*"))
    else:
        print("Error: template file and/or output folder does not exist!")

Geometry.Part.Cube(iPartColor=4803000)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], dlLength=[0.02, 0.01, 0.01],
    ilAxialNodes=[100, 5, 3], strName="Cube_2", iPartColor=14540142)
Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0], dlLength=[0.005, 0.01, 0.01],
    ilAxialNodes=[30, 60, 40], strName="Cube_3", iPartColor=6678885)
Geometry.Part.Cube(dlOrigin=[0.035, 0.0, 0.0], dlLength=[0.04, 0.004, 0.03],
    ilAxialNodes=[100, 40, 70], strName="Cube_4", iPartColor=11817908)

export_report(template_file, output_folder)
