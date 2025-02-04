(* Copyright (c) 2021 Nathan Rebours <nathan.p.rebours@gmail.com>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 *)

open Import

type t
(** Type for mapping from symbols to addresses *)

val empty : t

val from_binary_section : X86_emitter.buffer addressed -> t
(** Create a mapping for all symbols in the given section. Some symbols
    that should be available globally, such as ["caml_absf_mask"] will not
    be ignored so that we always use the global ones. *)

val union : t -> t -> t
(** Returns the union of two symbols mappings. Raises an exception if there
    are conflicts *)

val find : t -> string -> Address.t option
(** Lookup a symbol's address in the given symbol map. If it is missing from the map
    look it up using dlsym. *)

val dprint : t -> unit
(** Debug printer for symbol table *)
