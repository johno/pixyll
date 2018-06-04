#ifndef CORE_EXTENSIONS_H
#define CORE_EXTENSIONS_H

#ifdef __cplusplus
extern "C" {
#endif

#include <cmark_extension_api.h>
#include "cmarkextensions_export.h"
#include <stdint.h>

CMARKEXTENSIONS_EXPORT
void core_extensions_ensure_registered(void);

CMARKEXTENSIONS_EXPORT
uint16_t cmarkextensions_get_table_columns(cmark_node *node);

CMARKEXTENSIONS_EXPORT
uint8_t *cmarkextensions_get_table_alignments(cmark_node *node);

#ifdef __cplusplus
}
#endif

#endif
