# Invarix.Guard Models

ONNX model weights used by [Invarix.Guard](https://www.nuget.org/packages/Invarix.Guard), a plug and play AI safety middleware for .NET.

The binaries are published as assets on tagged [GitHub Releases](../../releases); this repository itself only holds the manifest, attribution, and tooling.

## Models

| File | Purpose | Size | Upstream source | License |
|------|---------|------|-----------------|---------|
| `toxicity.onnx` | Multilingual toxicity classification (104 languages, DistilBERT, FP32 — INT8 drops accuracy below usable thresholds) | ~515 MB | [citizenlab/distilbert-base-multilingual-cased-toxicity](https://huggingface.co/citizenlab/distilbert-base-multilingual-cased-toxicity) | Apache-2.0 |
| `embedding.onnx` + `embedding.spm.model` | Multilingual sentence embeddings for semantic harm-category classification + Pro custom-blocklist scanner (100+ languages, e5-base / XLM-RoBERTa, 768-dim, FP32) | ~1.06 GB | [intfloat/multilingual-e5-base](https://huggingface.co/intfloat/multilingual-e5-base) | MIT |
| `prompt_injection.onnx` | Prompt-injection and jailbreak binary classifier (DeBERTa v3, FP32 — INT8 corrupts DeBERTa disentangled attention) | ~705 MB | [protectai/deberta-v3-base-prompt-injection-v2](https://huggingface.co/protectai/deberta-v3-base-prompt-injection-v2) | Apache-2.0 |
| `pii_ner.onnx` | Multilingual PII NER, 20 entity types (XLM-RoBERTa, FP32 — INT8 destroys NER accuracy) | ~1.05 GB | [onnx-community/multilang-pii-ner-ONNX](https://huggingface.co/onnx-community/multilang-pii-ner-ONNX) | Apache-2.0 |

The [`manifest.json`](./manifest.json) at the repo root lists the current release tag, download URLs, sizes, and SHA-256 checksums.

## Usage

Install the [`Invarix.Guard`](https://www.nuget.org/packages/Invarix.Guard) NuGet package and it handles everything — picking which models to fetch, downloading, verifying, and caching:

```bash
dotnet add package Invarix.Guard
```

See the [Invarix.Guard documentation](https://www.nuget.org/packages/Invarix.Guard) for configuration details.

For air-gapped installs, download the assets directly from the [Releases page](../../releases).

## License and attribution

The scaffolding in this repository (manifest format, scripts, documentation) is MIT-licensed — see [LICENSE](./LICENSE).

The model weights remain under their respective upstream Apache-2.0 licenses. Per-model attribution is in [NOTICE](./NOTICE).
