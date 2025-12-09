
package com.pdftools.deletepdfpage
import androidx.core.view.WindowCompat

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import com.tom_roush.pdfbox.pdmodel.PDDocument
import java.io.File

class MainActivity : FlutterActivity() {
    private val CHANNEL = "pdf_utils"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        WindowCompat.setDecorFitsSystemWindows(window, false)
        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "removePages" -> {
                    val filePath = call.argument<String>("filePath")
                    val pages = call.argument<List<Int>>("pages")
                    if (filePath != null && pages != null) {
                        val modifiedPdf = removePagesFromPDF(filePath, pages)
                        result.success(modifiedPdf)
                    } else {
                        result.error("INVALID_ARGS", "Invalid arguments", null)
                    }
                }
                "getTotalPages" -> {
                    val filePath = call.argument<String>("filePath")
                    if (filePath != null) {
                        val pageCount = getTotalPages(filePath)
                        if (pageCount != null) {
                            result.success(pageCount)
                        } else {
                            result.error("READ_ERROR", "Failed to read PDF", null)
                        }
                    } else {
                        result.error("INVALID_ARGS", "Invalid file path", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }



    private fun removePagesFromPDF(filePath: String, pages: List<Int>): String? {
        return try {
            val file = File(filePath)
            val document = PDDocument.load(file)
            pages.sortedDescending().forEach { pageIndex ->
                document.removePage(pageIndex - 1)
            }
            val outputFile = File(file.parent, "modified.pdf")
            document.save(outputFile)
            document.close()
            outputFile.absolutePath
        } catch (e: Exception) {
            null
        }
    }

    private fun getTotalPages(filePath: String): Int? {
        return try {
            val file = File(filePath)
            val document = PDDocument.load(file)
            val pageCount = document.numberOfPages
            document.close()
            pageCount
        } catch (e: Exception) {
            null
        }
    }

}
